# Base image with conda and mamba
FROM condaforge/miniforge3:25.9.1-0

# Set working directory
WORKDIR /home/jovyan

# Copy environment lock file
COPY conda-lock.yml .

# Create environment from lock file
RUN conda install -c conda-forge conda-lock -y && \
    conda-lock install -n dsci310 conda-lock.yml && \
    conda clean -afy

#downloading R pacakge
RUN conda run -n dsci310 Rscript -e 'pak::pak("UBC-DSCI-310-2025W2/wrangle-viz-tools-group-12")'
# Activate the environment
ENV PATH=/opt/conda/envs/dsci310/bin:$PATH
# RUN echo "conda activate dsci310" >> ~/.bashrc #use this if it dont work
# Copy project files
COPY . .

# Launch Jupyter when container starts
CMD ["conda", "run", "--no-capture-output", "-n", "dsci310", "jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]