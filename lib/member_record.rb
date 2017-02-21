# frozen_string_literal: true
require_relative 'scraped/json'

class MemberRecord < Scraped::JSON
  field :id do
    json[:id]
  end

  field :name do
    names.first.tidy
  end

  field :alternate_names do
    names.drop(1).map(&:tidy).join(';')
  end

  field :cell do
    contact_detail_for('cell')
  end

  field :text do
    contact_detail_for('text')
  end

  field :phone do
    contact_detail_for('voice')
  end

  field :email do
    contact_detail_for('email')
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

  field :language_code do
    person[:language_code]
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
    json[:on_behalf_of][:name]
  end

  private

  def names
    person[:name].split('(or)')
  end

  def person
    json[:person]
  end

  def contact_detail_for(type)
    contact = person[:contact_details].find { |c| c[:type] == type }
    contact[:value] if contact
  end
end
