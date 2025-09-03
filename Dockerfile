# Generic nginx proxy with envsubst templating support
FROM nginx:alpine

# Install gettext for envsubst (if not already present)
RUN apk add --no-cache gettext

# Copy template files
COPY templates/ /etc/nginx/templates/

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/health || exit 1

EXPOSE 80

# nginx will automatically process templates in /etc/nginx/templates/*.template
# and output to /etc/nginx/conf.d/ using envsubst
CMD ["nginx", "-g", "daemon off;"]
