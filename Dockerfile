FROM python:3.11-slim

# install uv
COPY --from=ghcr.io/astral-sh/uv:0.4.2 /uv /bin/uv

WORKDIR /app

# install dependencies
COPY uv.lock /app/uv.lock
COPY pyproject.toml /app/pyproject.toml
RUN --mount=type=cache,target=/root/.cache/uv uv sync --frozen

COPY hello.py /app
ENV PATH="/app/.venv/bin:$PATH"

CMD ["fastapi", "run", "hello.py", "--port", "8000", "--host", "0.0.0.0"]