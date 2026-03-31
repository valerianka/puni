-- Create schema_migrations table to track applied migrations
CREATE TABLE IF NOT EXISTS schema_migrations (
  version VARCHAR PRIMARY KEY
);

-- Insert all migration versions (marked as already applied)
INSERT OR IGNORE INTO schema_migrations (version) VALUES ('20150627210340');
INSERT OR IGNORE INTO schema_migrations (version) VALUES ('20150627210348');
INSERT OR IGNORE INTO schema_migrations (version) VALUES ('20150627213604');
INSERT OR IGNORE INTO schema_migrations (version) VALUES ('20150627215404');
INSERT OR IGNORE INTO schema_migrations (version) VALUES ('20150628001935');
INSERT OR IGNORE INTO schema_migrations (version) VALUES ('20150628002331');
INSERT OR IGNORE INTO schema_migrations (version) VALUES ('20150628170347');
INSERT OR IGNORE INTO schema_migrations (version) VALUES ('20150628201057');
INSERT OR IGNORE INTO schema_migrations (version) VALUES ('20151203033401');
INSERT OR IGNORE INTO schema_migrations (version) VALUES ('20151203052451');
INSERT OR IGNORE INTO schema_migrations (version) VALUES ('20160301043124');
INSERT OR IGNORE INTO schema_migrations (version) VALUES ('20160301044058');
INSERT OR IGNORE INTO schema_migrations (version) VALUES ('20160301053517');
