FROM directus/directus:11

USER root
RUN corepack enable
RUN apk update && apk add --no-cache sqlite jq imagemagick ghostscript font-inconsolata font-noto font-noto-extra libqrencode-tools

# Install the Human-Readable-ID directus extension - used to generate invite codes
# and the mailing lists extension - used to send emails to guests
USER node
RUN pnpm install directus-extension-human-readable-id
RUN pnpm install directus-extension-mailing-lists
RUN pnpm install directus-extension-generate-invitations-endpoint
RUN pnpm install directus-extension-table-layout

# Copy the initial database, uploads, and templates
COPY --chown=node:node ./database /directus/database
COPY --chown=node:node ./uploads /directus/uploads
COPY --chown=node:node ./templates /directus/templates
COPY ./entrypoint.sh /entrypoint.sh

# Run the setup script and start Directus
ENV HOST=0.0.0.0
ENV PORT=8055
EXPOSE ${PORT}
CMD ["/bin/sh", "-c", "/entrypoint.sh"]
