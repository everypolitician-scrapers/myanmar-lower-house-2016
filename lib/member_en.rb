require_relative 'member'

class MemberEN < Member
  field :id do
    member[:id]
  end

  field :name__en do
    names.first.tidy
  end

  field :alternate_names__en do
    names.drop(1).map(&:tidy).join(';')
  end

  field :family_name__en do
    person[:family_name]
  end

  field :additional_name__en do
    person[:additional_name]
  end

  field :honorific_prefix__en do
    person[:honorific_prefix]
  end

  field :honofific_suffix__en do
    person[:honofific_suffix]
  end

  field :patronymic_name__en do
    person[:patronymic_name]
  end

  field :sort_name__en do
    person[:sort_name]
  end

  field :gender do
    person[:gender]
  end

  field :summary__en do
    person[:summary]
  end

  field :biography__en do
    person[:biography]
  end

  field :national_identity__en do
    person[:national_identity]
  end

  field :party__en do
    member[:on_behalf_of][:name]
  end
end
