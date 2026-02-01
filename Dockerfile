FROM directus/directus:11

USER root
RUN corepack enable
RUN apk update && apk add --no-cache sqlite

# Install the Human-Readable-ID directus extension
# this is used to generate the invite codes
USER node
RUN pnpm install directus-extension-human-readable-id

# Copy the initial database and uploads
COPY --chown=node:node ./database /directus/database
COPY --chown=node:node ./uploads /directus/uploads
COPY ./entrypoint.sh /entrypoint.sh

# Run the setup script and start Directus
ENV HOST=0.0.0.0
ENV PORT=8055
EXPOSE ${PORT}
CMD ["/bin/sh", "-c", "/entrypoint.sh"]
