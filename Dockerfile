# Use the official Node.js 18 image
FROM node:18

# Install necessary dependencies for Chromium
RUN apt-get update && apt-get install -y \
  wget \
  curl \
  gnupg \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libcups2 \
  libgdk-pixbuf2.0-0 \
  libnspr4 \
  libnss3 \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  libgbm1 \
  libxss1 \
  fonts-liberation \
  libappindicator3-1 \
  xdg-utils \
  libasound2 \
  lsb-release \
  libdbus-1-3 \
  libxtst6 \
  libgconf-2-4 \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install dependencies (project + Playwright)
RUN npm install \
  && npx playwright install --with-deps

# Expose your app port
EXPOSE 3000

# Start the server
CMD ["npm", "start"]
