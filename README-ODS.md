зайди в  докер танго:

docker exec -it tango_container bash

внутри него(!) надо скачать еще один докер имидж:

docker pull cmudeeplearning11785/machine_learning_image

потом его надо переименовать, чтоб не было / и старый тег удалить:

docker tag cmudeeplearning11785/machine_learning_image cmudlimage

docker rmi cmudeeplearning11785/machine_learning_image

выйти из контейнера (exit) и закомитить изменения в имидж

docker commit container_id image_name

