FROM node:24-alpine AS builder

WORKDIR /app

COPY package*.json yarn.lock ./

RUN yarn install --frozen-lockfile --production

COPY . .

RUN yarn build

FROM node:24-alpine AS runner

WORKDIR /app
COPY --from=builder /app/.output ./.output

EXPOSE 3000

CMD ["node", ".output/server/index.mjs"]