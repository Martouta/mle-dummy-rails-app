# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_220_928_084_225) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', precision: nil, null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', precision: nil, null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'event_store_events', id: :serial, force: :cascade do |t|
    t.uuid 'event_id', null: false
    t.string 'event_type', null: false
    t.binary 'metadata'
    t.binary 'data', null: false
    t.datetime 'created_at', precision: nil, null: false
    t.datetime 'valid_at', precision: nil
    t.index ['created_at'], name: 'index_event_store_events_on_created_at'
    t.index ['event_id'], name: 'index_event_store_events_on_event_id', unique: true
    t.index ['event_type'], name: 'index_event_store_events_on_event_type'
    t.index ['valid_at'], name: 'index_event_store_events_on_valid_at'
  end

  create_table 'event_store_events_in_streams', id: :serial, force: :cascade do |t|
    t.string 'stream', null: false
    t.integer 'position'
    t.uuid 'event_id', null: false
    t.datetime 'created_at', precision: nil, null: false
    t.index ['created_at'], name: 'index_event_store_events_in_streams_on_created_at'
    t.index %w[stream event_id], name: 'index_event_store_events_in_streams_on_stream_and_event_id', unique: true
    t.index %w[stream position], name: 'index_event_store_events_in_streams_on_stream_and_position', unique: true
  end

  create_table 'resources', force: :cascade do |t|
    t.string 'user_id'
    t.string 'reference_id'
    t.string 'language_code'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'integration', null: false
    t.index ['created_at'], name: 'index_resources_on_created_at'
    t.index %w[integration reference_id], name: 'index_resources_on_integration_and_reference_id', unique: true,
                                          where: '(reference_id IS NOT NULL)'
    t.index ['integration'], name: 'index_resources_on_integration'
    t.index ['language_code'], name: 'index_resources_on_language_code'
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
end
