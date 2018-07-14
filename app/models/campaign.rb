class Campaign < ApplicationRecord
  belongs_to :user
  has_many :members, dependent: :destroy
  before_validation :set_member, on: :create
  before_validation :set_status, on: :create
  enum status: [:pending, :finished]
  validates :title, :description, :user, :status, presence: true

  def count_opened
    self.members.where(open: true).count
  end

  private

    def set_status
      self.status = :pending
    end

    def set_member
      self.members << Member.create(name: self.user.name, email: self.user.email)
    end
end
