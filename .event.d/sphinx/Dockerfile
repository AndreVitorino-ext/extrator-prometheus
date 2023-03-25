FROM python:3.7

USER root

RUN pip install \
  Sphinx==2.4.4 \
  sphinxcontrib-confluencebuilder \
  recommonmark \
  sphinx-markdown-tables \
  myst-parser \
  pyyaml \
  yamldoc

COPY entrypoint entrypoint
RUN chmod +x /entrypoint
WORKDIR /.$
ENTRYPOINT ["/entrypoint"]

