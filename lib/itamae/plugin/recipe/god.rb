require "itamae/plugin/recipe/god/version"

include_recipe './god/stop'
include_recipe './god/install'

include_seasoning if respond_to?(:include_seasoning)

include_recipe './god/start'
