# Generic nginx proxy with envsubst templating support
FROM nginx:alpine

# Install gettext for envsubst (if not already present)
RUN apk add --no-cache gettext

# Copy template files
COPY templates/ /etc/nginx/templates/

# Health check
HEALTHCHECK --interval=5s --timeout=2s --start-period=2s --retries=2 \
  CMD wget --quiet --tries=1 --spider http://127.0.0.1/health || exit 1


EXPOSE 80

# nginx will automatically process templates in /etc/nginx/templates/*.template
# and output to /etc/nginx/conf.d/ using envsubst
CMD ["nginx", "-g", "daemon off;"]
