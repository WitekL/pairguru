class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    "https://pairguru-api.herokuapp.com/#{slugify_poster(object.title)}.jpg"
  end

  def description
    description = context[object.title].dig('data', 'attributes', 'plot')

    return 'This movie could not be found. Sorry!' if description.nil?

    description
  end

  def rating
    context[object.title].dig('data', 'attributes', 'rating')
  end

  private

  def slugify_poster(title)
    title.downcase.gsub(/\s+/, '_')
  end
end
