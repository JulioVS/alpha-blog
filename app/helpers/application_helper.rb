module ApplicationHelper

  def gravatar_for(user, options = { size: 80})
    email_address = user.email.downcase 
    hash = Digest::MD5.hexdigest(email_address) 
    size = options[:size] 
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}" 
    image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block") 
  end

  # Borro el metodo "current_user" de aqui para pasarlo a AplicationController,
  # pues de esa manera puede ser usado en todos los controllers, como por
  # ejemplo para cargar el usuario creador de un articulo en "article#create"
  #
  # Alli mismo a su vez incluso el comando "helper_method" para que tambien
  # pueda ser utilizado por las Views, como cuando estaba redactado aqui.-
  #
  # def current_user
  #   ...

  # Hago lo mismo con "logged_in?", lo paso para ApplicationController para 
  # darle mas scope.-
  #
  # def logged_in?
  #   ...

 end
