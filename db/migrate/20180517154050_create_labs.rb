class CreateLabs < ActiveRecord::Migration[5.1]
  def change
    create_table :labs do |t|
      t.string :chart_id
      t.float :cholest_SerPI_mCnc
      t.float :HDLc_SerPI_mCnc
      t.float :Trigl_SerPI_mCnc
      t.float :LDLc_SerPI_Calc_mCnc
      t.float :Glucose_SerPI_mCnc
      t.float :Hgb_A1c_MFr_Bld
      t.float :VLDL
      t.float :HSCRP
      t.date :received_date
      t.string :source
      t.date :reported_date
      t.text :notes

      t.timestamps
    end
  end
end
