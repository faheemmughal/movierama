class UserMailer < ActionMailer::Base
  default from: 'notifications@movierama.com'

  def notification_email(vote_caster, movie, like_or_hate)
    @vote_caster  = vote_caster
    @movie        = movie
    @like_or_hate = like_or_hate
    @user         = @movie.user

    mail(to: @user.email, subject: 'Your movie has a new vote!')
  end
end
