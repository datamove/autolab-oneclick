class CreateOdsUser
  def initialize(data)
    @data = data
  end

  def call
    user = User.find_for_github_oauth(data)
    return user if user.present?

    user = User.find_by(email: data["info"]["email"])
    if user.present?
      user.authentications.create(provider: data["provider"], uid: data["uid"])
      return user
    end

    user = User.new

    ActiveRecord::Base.transaction do
      #use nickname and uid to avoid issues if name is not in ascii
      user.first_name = data["info"]["nickname"]
      user.last_name = data["uid"]
      #user.first_name = data["info"]["name"].split(' ', 2).first || data["info"]["nickname"]
      #user.last_name = data["info"]["name"].split(' ', 2).last || data["info"]["nickname"]
      user.email = data["info"]["email"]
      user.authentications.new(provider: data["provider"], uid: data["uid"])
      temp_pass = Devise.friendly_token[0, 20]
      user.password = temp_pass
      user.password_confirmation = temp_pass
      user.save!

      course = Course.find_by(name: 'CMUDL')
      cud = course.course_user_data.new
      cud.user = user
      cud.assign_attributes(nickname: data["info"]["nickname"], lecture: '', section: '', grade_policy: '')
      cud.save(validate: false)
    end

    user
  end

  private

  attr_reader :data
end

