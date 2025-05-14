# Use the official Node.js 18 image
FROM node:18

# Install dependencies to run Chromium
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
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libnss3 \
  libxss1 \
  xdg-utils \
  libasound2 \
  lsb-release \
  libdbus-1-3 \
  libxtst6 \
  libgbm1 \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  libgdk-pixbuf2.0-0 \
  libnss3 \
  libgconf-2-4

# Install Chromium via a direct download link
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
  apt install -y ./google-chrome-stable_current_amd64.deb && \
  rm google-chrome-stable_current_amd64.deb

# Install Playwright and other dependencies
RUN npm install -g playwright

# Set working directory in the container
WORKDIR /app

# Copy all project files into the container
COPY . .

# Install project dependencies
RUN npm install

# Expose necessary port (if required)
EXPOSE 3000

# Command to run your app (Start server)
CMD ["npm", "start"]
