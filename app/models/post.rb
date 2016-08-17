class Post < ApplicationRecord
  before_save :filter_sensitive_word

  validates_presence_of :title, :content

  private

  def filter_sensitive_word
    do_something_really_takes_time

    ''
  end

  def do_something_really_takes_time
    # sleep 5
  end
end
