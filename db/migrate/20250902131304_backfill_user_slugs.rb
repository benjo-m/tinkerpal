class BackfillUserSlugs < ActiveRecord::Migration[8.0]
  def change
    User.where(slug: [ nil, "" ]).find_each do |user|
      user.update_columns(slug: user.username.parameterize)
    end
  end
end
