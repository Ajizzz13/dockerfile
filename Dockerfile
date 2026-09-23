FROM mcr.microsoft.com/playwright:v1.50.0-noble

WORKDIR /app

RUN apt-get update && apt-get install -y git curl unzip && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:$PATH"

RUN git clone https://github.com/youssefvdel/qwen-gate.git .
RUN bun install
RUN bunx playwright install chromium
RUN ln -s $(find /ms-playwright -name chrome -type f | head -n 1) /usr/local/bin/chromium-browser

ENV HOST=0.0.0.0
EXPOSE 26405

CMD ["bun", "start"]
