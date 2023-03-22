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
&& rm -rf /var/lib/apt/lists/* \
&& echo "progress = dot:giga" | tee /etc/wgetrc \
&& mkdir -p /mnt /opt /data \
&& wget https://github.com/andmarios/duphard/releases/download/v1.0/duphard -O /bin/duphard \
&& chmod +x /bin/duphard

# Clone the pa11y-webservice repository
RUN git clone https://github.com/agoldschmidt/pa11y-webservice.git .

# Install the dependencies
RUN npm install

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
