const express = require("express");
const { chromium } = require("playwright");

const app = express();
const port = process.env.PORT || 3000;

app.get("/extract-t-hash", async (req, res) => {
  let browser;
  try {
    browser = await chromium.launch({
      headless: true,
      args: [
        "--no-sandbox",
        "--disable-blink-features=AutomationControlled",
        "--disable-dev-shm-usage",
        "--disable-gpu",
        "--disable-setuid-sandbox",
        "--no-zygote",
      ],
    });

    const context = await browser.newContext({
      viewport: { width: 1280, height: 720 },
      userAgent:
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36",
    });

    const page = await context.newPage();

    // Make navigator.webdriver false to avoid bot detection
    await page.addInitScript(() => {
      Object.defineProperty(navigator, "webdriver", {
        get: () => false,
      });
    });

    await page.goto("https://netfree2.cc/tv/home", {
      waitUntil: "load",
    });

    // Give time to ensure everything loads
    await page.waitForTimeout(1500);

    // Extract cookies
    const t_hash_t = await page.evaluate(() => {
      return document.cookie;
    });

    await browser.close();
    res.json({ t_hash_t });
  } catch (error) {
    console.error("Error extracting t_hash_t:", error);
    if (browser) await browser.close();
    res.status(500).send("Error extracting t_hash_t");
  }
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
