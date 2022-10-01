test_grid = ds_grid_create(2, 5);
ds_grid_add(test_grid, 0, 0, "Potato")
ds_grid_add(test_grid, 1, 0, 2)
ds_grid_add(test_grid, 0, 1, "Apple")
ds_grid_add(test_grid, 1, 1, 11)
ds_grid_add(test_grid, 0, 2, "Crowbar")
ds_grid_add(test_grid, 1, 2, 1)
ds_grid_add(test_grid, 0, 3, "Celery")
ds_grid_add(test_grid, 1, 3, 30)
ds_grid_add(test_grid, 0, 4, -1)
ds_grid_add(test_grid, 1, 4, -1)

alarm[0] = 10;