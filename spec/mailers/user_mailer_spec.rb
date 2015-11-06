require 'rails_helper'

RSpec.describe UserMailer do

  describe "#notification_email" do
    let(:user) do
      User.create(
        uid: 'null|12345',
        name: 'Critic',
        email: 'bit-bucket@test.smtp.org'
      )
    end

    let(:author) do
      User.create(
        uid: 'null|12346',
        name: 'The real Bob',
        email: 'bit-bucket@test.smtp.org'
      )
    end

    let!(:email) { UserMailer.notification_email(user, movie, 'like').deliver}

    let(:movie) do
      Movie.create(
        title:        'Empire strikes back',
        description:  'Who\'s scruffy-looking?',
        date:         '1980-05-21',
        created_at:   Time.parse('2014-10-01 10:30 UTC').to_i,
        user:         author,
        liker_count:  50,
        hater_count:  2
      )
    end

    let(:email_content) do
      "Your movie Empire strikes back was liked by Critic."
    end

    it "sends a message" do
      expect(ActionMailer::Base.deliveries).not_to be_empty
    end

    it "has proper headers" do
      expect(email.from).to eq(['notifications@movierama.com'])
      expect(email.to).to eq([movie.user.email])
      expect(email.subject).to eq('Your movie has a new vote!')
      expect(email.body.to_s).to include(email_content)
    end
  end
end
