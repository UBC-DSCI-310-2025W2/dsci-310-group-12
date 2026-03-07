# Base image with conda and mamba
FROM condaforge/miniforge3:25.9.1-0

# Set working directory
WORKDIR /home/jovyan

# Copy environment lock file
COPY conda-linux-64.lock .

# Create environment from lock file
RUN mamba create -y -n dsci310 --file conda-linux-64.lock && \
    conda clean -afy

# Activate the environment
ENV PATH /opt/conda/envs/dsci310/bin:$PATH

# Copy project files
COPY . .

# Launch Jupyter when container starts
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]