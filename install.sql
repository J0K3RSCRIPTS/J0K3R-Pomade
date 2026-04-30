-- =====================================================================
-- j0k3r-pomade :: SQL Setup
-- ---------------------------------------------------------------------
-- Run this file once against your VORP database (the same database
-- used by vorp_inventory). It adds the default `pomade` item.
--
-- If you've added more items to Config.Items in config.lua, copy the
-- INSERT line and adjust the values accordingly.
--
-- Author : J0K3R-Scripts
-- Discord: https://discord.gg/DH8tW6vSxV
-- =====================================================================

INSERT INTO `items`
    (`item`, `label`, `limit`, `usable`, `type`, `can_remove`, `desc`)
VALUES
    ('pomade', 'Hair Pomade', 5, 1, 'item_standard', 1,
     'A small jar of slick, scented pomade. Apply to keep your hair tidy and stylish.');

-- Example: a premium variant
-- INSERT INTO `items`
--     (`item`, `label`, `limit`, `usable`, `type`, `can_remove`, `desc`)
-- VALUES
--     ('pomade_premium', 'Premium Hair Pomade', 5, 1, 'item_standard', 1,
--      'An imported, lavender-scented hair pomade for the gentleman.');
