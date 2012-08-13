#coding: utf-8
require 'spec_helper'

describe Room do
  let(:room){Fabricate(:room)}

  describe "Новый кабинет должен иметь все предметы по-умолчанию" do
    it "когда нет предметов - в списке пусто" do
      room.subjects.should == []
    end

    describe "Новый кабинет должен иметь все предметы по-умолчанию" do
      before(:each) do
        room.subjects << Fabricate(:subject, name: 'География')
        room.subjects << Fabricate(:subject, name: 'Геометрия')
      end

      it "когда два предмета добавлены - в списке оба" do
        room.subjects.count.should == 2
      end

      it "если один удалить - остался один" do
        room.subjects.first.delete
        room.subjects.count.should == 1
      end

    end
  end
end