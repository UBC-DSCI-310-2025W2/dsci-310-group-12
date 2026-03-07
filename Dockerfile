# Base image with conda and mamba
FROM condaforge/miniforge3:25.9.1-0

# Set working directory
WORKDIR /home/jovyan

# Copy environment lock file
COPY conda-linux-64.lock .

# Create environment from lock file
RUN conda install -c conda-forge conda-lock -y && \
    conda-lock install -n dsci310 conda-linux-64.lock

# Activate the environment
ENV PATH=/opt/conda/envs/dsci310/bin:$PATH

# Copy project files
COPY . .

# Launch Jupyter when container starts
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]