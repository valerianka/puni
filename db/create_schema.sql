-- Create munis table
CREATE TABLE IF NOT EXISTS munis (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  route_name VARCHAR NOT NULL,
  avg_smell_rating INTEGER DEFAULT 1,
  avg_clean_rating INTEGER DEFAULT 1,
  avg_driver_rating INTEGER DEFAULT 1
);

-- Create reports table
CREATE TABLE IF NOT EXISTS reports (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  smell_rating INTEGER NOT NULL,
  clean_rating INTEGER NOT NULL,
  driver_rating INTEGER NOT NULL,
  muni_id INTEGER NOT NULL
);

-- Create index on reports.muni_id
CREATE INDEX IF NOT EXISTS index_reports_on_muni_id ON reports(muni_id);

-- Create stories table
CREATE TABLE IF NOT EXISTS stories (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  content TEXT NOT NULL,
  img_url VARCHAR,
  report_id INTEGER NOT NULL
);

-- Create index on stories.report_id
CREATE INDEX IF NOT EXISTS index_stories_on_report_id ON stories(report_id);
