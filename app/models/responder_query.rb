class ResponderQuery
  def initialize(relation = Responder.all)
    @relation = relation.extending(Scopes)
  end

  def search
    @relation
  end

  def total(options = {})
    search.where(options)
  end

  def available(options = {})
    search.where(options).unassigned
  end

  def on_duty(options = {})
    search.where(options).on_duty
  end

  def available_and_on_duty(options = {})
    search.where(options).unassigned.on_duty
  end

  module Scopes
    def unassigned
      where(emergency: nil)
    end

    def on_duty
      where(on_duty: true)
    end

    def capacity
      sum(:capacity)
    end
  end
end
