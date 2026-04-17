# Esta es la receta principal: orquesta la instalación completa del stack LAMP + WordPress
include_recipe 'wordpress::apache'
include_recipe 'wordpress::mysql'
include_recipe 'wordpress::php'
include_recipe 'wordpress::wordpress'
