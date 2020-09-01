class Admin::PagesController < ApplicationController

  # Смотри, я разделил контроллеры, на admin и на api спейсы. В admin я оставл контроллеры на выходе которых вьхи (html), так что этот контроллер ты можешь перенест и в api.
  # Что мне тут не понравилось, контроллер называется PagesController, но работаешь ты тут с Post
  # Я бы удалил этот контроллер. Работу с api Post я вынес в controllers/api/posts_controller.rb.

  def about
    # 1) Прочитать про includes - что это такое и для чего нужно https://engineering.gusto.com/a-visual-guide-to-using-includes-in-rails/
    # 2) Прочить про проблему N+1 https://semaphoreci.com/blog/2017/08/09/faster-rails-eliminating-n-plus-one-queries.html
    # 3) Прочитать про as_json https://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html
    @post = Post.includes([:comments]).all

    render json: @post.as_json(include: :comments)
  end
end

