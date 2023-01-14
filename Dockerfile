FROM python:3.7.16-slim-bullseye

# Set the working directory
RUN mkdir /opt/indoor
WORKDIR /opt/indoor

# Copy the requirements file
COPY requirements.txt /opt/indoor

# Install the dependencies
RUN pip install -r requirements.txt

# Copy the rest of the project files
COPY . /opt/indoor

RUN python3 -m venv venv \
    && venv/bin/pip install -r requirements.txt

# Set the Django settings module
ENV DJANGO_SETTINGS_MODULE=inDoor.settings


RUN python3 -m pip install --upgrade pip
RUN pip install pip --upgrade pip
RUN pip install -r requirements.txt
RUN python manage.py migrate

# Run the Django development server
EXPOSE 8000
CMD ["venv/bin/python", "manage.py", "runserver", "0.0.0.0:8000"]


## Set work directory
#
#WORKDIR /code
#ADD . /code
#
## Install dependencies
#RUN pip install pip --upgrade pip
#RUN pip install -r requirements.txt
#
## Copy project
#
#CMD python manage.py runserver 0:8000