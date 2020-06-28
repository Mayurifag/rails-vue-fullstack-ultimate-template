FROM cypress/included:4.9.0

WORKDIR /app

COPY cypress.json .

RUN npx cypress verify
