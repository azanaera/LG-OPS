// Turns the mermaid sources in diagrams/src/*.html into finished pages in diagrams/*.html
// with every diagram drawn as an inline SVG, so a page never depends on a viewer to draw it.
//
// Usage: copy this file into a scratch folder that has the two packages installed, and run it there:
//   npm init -y && npm i mermaid@10.9.1 puppeteer-core@22.15.0
//   CHROME="C:/Program Files/Google/Chrome/Application/chrome.exe" node <repo>/tools/build-diagrams.mjs <repo>/diagrams
import puppeteer from 'puppeteer-core';
import fs from 'node:fs';
import path from 'node:path';

const dir = path.resolve(process.argv[2] || 'diagrams');
const chrome = process.env.CHROME || 'C:/Program Files/Google/Chrome/Application/chrome.exe';
const mermaidJs = path.resolve('node_modules/mermaid/dist/mermaid.min.js').replace(/\\/g, '/');
const pages = ['process-diagrams', 'process-detail', 'access-and-release'];
const decode = s => s.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&amp;/g, '&');
const attr = s => s.replace(/&/g, '&amp;').replace(/"/g, '&quot;');

const holder = path.resolve('.render-host.html'); // beside node_modules, where Chrome may load the script
fs.writeFileSync(holder, `<!doctype html><html><head><meta charset="utf-8"></head><body><script src="file:///${mermaidJs}"></script></body></html>`);
const browser = await puppeteer.launch({ executablePath: chrome, headless: 'new', args: ['--allow-file-access-from-files', '--no-sandbox'] });
const page = await browser.newPage();
await page.goto('file:///' + holder.replace(/\\/g, '/'));
await page.waitForFunction('typeof mermaid !== "undefined"');
await page.evaluate(() => mermaid.initialize({ startOnLoad: false, theme: 'default', flowchart: { htmlLabels: false, useMaxWidth: true }, sequence: { useMaxWidth: true }, state: { useMaxWidth: true } }));

let total = 0;
for (const name of pages) {
  const src = fs.readFileSync(path.join(dir, 'src', name + '.html'), 'utf8').replace(/\r\n/g, '\n');
  let h2 = '', h3 = '', out = '', last = 0;
  const re = /<h2>([^<]*)<\/h2>|<h3>([^<]*)<\/h3>|<pre class="mermaid">\n([\s\S]*?)\n\s*<\/pre>/g;
  let m;
  while ((m = re.exec(src))) {
    if (m[1] !== undefined) { h2 = m[1]; h3 = ''; continue; }
    if (m[2] !== undefined) { h3 = m[2]; continue; }
    const code = decode(m[3]);
    const svg = await page.evaluate(async (c, id) => (await mermaid.render(id, c)).svg, code, 'dg' + (++total));
    if (/Syntax error in text/.test(svg)) throw new Error(`diagram ${total} in ${name} failed`);
    const label = 'Diagram: ' + [h2, h3].filter(Boolean).join(', ');
    out += src.slice(last, m.index) + `<div class="dg" role="img" aria-label="${attr(label)}">${svg}</div>`;
    last = m.index + m[0].length;
  }
  out += src.slice(last);
  fs.writeFileSync(path.join(dir, name + '.html'), out);
  console.log(name, 'built, diagrams so far:', total);
}
await browser.close();
fs.rmSync(holder);
