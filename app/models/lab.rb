class Lab < ApplicationRecord
  validate :validate_chart_and_received_date_are_unique, on: :create
  validate :date_cannot_be_future
  attr_accessor :file

  def validate_chart_and_received_date_are_unique
    if self.class.where(chart_id: chart_id, received_date: received_date)
      .exists?
      errors.add(:base, "Chart ID and Received Date combination exists. To add more data to it, please search for this entry and update it manually")
    end
  end

  def date_cannot_be_future
    if received_date.present? && received_date > Date.today
      errors.add(:base, "Received Date can not be later than today's date, please make sure your input is correct")
    end
  end

  def self.search(search)
    if search
      where("chart_id ILIKE :q or cast(received_date as text) ILIKE :q", q: "%#{search}%")
    else
     all
    end
  end


end
