const express = require("express");
const { chromium } = require("playwright");

const app = express();
const port = process.env.PORT || 3000;

app.get("/extract-t-hash", async (req, res) => {
  try {
    const browser = await chromium.launch({ headless: true });
    const page = await browser.newPage();
    await page.goto("https://netfree2.cc/tv/home");

    const t_hash_t = await page.evaluate(() => {
      console.log(document.cookie);
      return document.cookie; // Extract t_hash_t from cookies
    });

    await browser.close();
    res.json({ t_hash_t });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).send("Error extracting t_hash_t");
  }
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
