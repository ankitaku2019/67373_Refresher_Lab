class Chore < ApplicationRecord
#Relationships
belongs_to :child
belongs_to :task

#Validations
validates_date :due_on

#Scope
scope :by_task, -> {includes(:task).order('tasks.name')}
scope :chronological, -> {joins(:task).order ('due_on, name')}
scope :pending, -> {where(completed:false)}
scope :done, -> {where(completed:true)}
scope :upcoming, -> {where("due_on >= ?", Date.current)}
scope :past, -> {where("due_on < ?", Date.current)}

#Methods
def status
    if self.completed
        return "Completed"
    else
        return "Pending"
    end
end
end
