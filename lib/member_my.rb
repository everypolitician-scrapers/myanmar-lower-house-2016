require_relative 'member'

class MemberMY < Member
  field :id do
    member[:id]
  end

  field :name do
    names.first.tidy
  end

  field :alternate_names do
    names.drop(1).map(&:tidy).join(';')
  end

  field :cell do
    contact_type('cell')
  end

  field :text do
    contact_type('text')
  end

  field :phone do
    contact_type('voice')
  end

  field :email do
    contact_type('email')
  end

  field :family_name do
    person[:family_name]
  end

  field :additional_name do
    person[:additional_name]
  end

  field :honorific_prefix do
    person[:honorific_prefix]
  end

  field :honofific_suffix do
    person[:honofific_suffix]
  end

  field :patronymic_name do
    person[:patronymic_name]
  end

  field :sort_name do
    person[:sort_name]
  end

  field :gender do
    person[:gender]
  end

  field :summary do
    person[:summary]
  end

  field :biography do
    person[:biography]
  end

  field :national_identity do
    person[:national_identity]
  end

  field :birth_date do
    person[:birth_date]
  end

  field :death_date do
    person[:death_date]
  end

  field :links do
    person[:links].join(';')
  end

  field :image do
    person[:image]
  end

  field :party do
    member[:on_behalf_of][:name]
  end
end
