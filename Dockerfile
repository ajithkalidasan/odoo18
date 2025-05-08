FROM odoo:18.0

USER root

# Create working directory
WORKDIR /opt/odoo

# Install any additional system dependencies here if needed
RUN apt-get update && apt-get install -y \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Create custom addons directory
RUN mkdir -p /opt/odoo/custom_addons

# Copy custom addons
COPY ./custom_addons /opt/odoo/custom_addons/

# Copy odoo.conf
COPY ./odoo.conf /opt/odoo/odoo.conf

# Set proper permissions
RUN chown -R odoo:odoo /opt/odoo

# Switch back to odoo user
USER odoo

EXPOSE 8069

CMD [ "odoo", "-c", "/opt/odoo/odoo.conf" ]