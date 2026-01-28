FROM directus/directus:11

USER root
RUN corepack enable
RUN apk update && apk add --no-cache sqlite

USER node
RUN pnpm install directus-extension-human-readable-id

COPY --chown=node:node ./database /directus/database
COPY --chown=node:node ./uploads /directus/uploads
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/sh", "-c", "/entrypoint.sh"]