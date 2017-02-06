module CapybaraFinders
  def list_item(content)
    find("tr", text: content)
  end
end

RSpec.configure do |c|
  c.include CapybaraFinders, type: :feature
end
