# Use the official Node.js LTS image as the base image
FROM node:lts

# Set the working directory
WORKDIR /app

# Update package lists and install required packages
RUN apt-get update \
&& apt-get install -y \
   unzip \
   wget \
   libnss3 \
   libgconf-2-4 \
   xvfb \
   ca-certificates \
   fonts-liberation \
   libasound2 \
   libatk-bridge2.0-0 \
   libatk1.0-0 \
   libc6 \
   libcairo2 \
   libcups2 \
   libdbus-1-3 \
   libexpat1 \
   libfontconfig1 \
   libgbm1 \
   libgcc1 \
   libglib2.0-0 \
   libgtk-3-0 \
   libnspr4 \
   libnss3 \
   libpango-1.0-0 \
   libpangocairo-1.0-0 \
   libstdc++6 \
   libx11-6 \
   libx11-xcb1 \
   libxcb1 \
   libxcomposite1 \
   libxcursor1 \
   libxdamage1 \
   libxext6 \
   libxfixes3 \
   libxi6 \
   libxrandr2 \
   libxrender1 \
   libxss1 \
   libxtst6 \
   lsb-release \
   wget \
   xdg-utils \
&& rm -rf /var/lib/apt/lists/* \
&& echo "progress = dot:giga" | tee /etc/wgetrc \
&& mkdir -p /mnt /opt /data \
&& wget https://github.com/andmarios/duphard/releases/download/v1.0/duphard -O /bin/duphard \
&& chmod +x /bin/duphard

# Create a non-root user and set the ownership of the working directory
RUN useradd -m simpleuser \
&& chown -R simpleuser:simpleuser /app

# Clone the pa11y-webservice repository
RUN git clone https://github.com/agoldschmidt/pa11y-webservice.git .

# Install the dependencies
RUN npm install

# Switch to the non-root user
USER simpleuser

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
