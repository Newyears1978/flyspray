<div class="project-menu" id="pm-menu">
	<input id="pmmenu" type="checkbox">
	<ul id="pm-menu-list"><?php
		if ( count($fs->projects) && $user->can_select_project($proj->id) && $proj->id != 0 ) {
			?><li class="first">
			<a id="toplevellink"
				<?php if($do == 'toplevel'): ?> class="active" <?php endif; ?>
			   href="<?php echo Filters::noXSS(CreateURL('toplevel', $proj->id)); ?>"><i class="fa fa-eye"></i> <?php echo Filters::noXSS(L('overview')); ?></a>
			</li><?php
		}
		if( (!$user->isAnon() && $user->perms('view_tasks') && $proj->id != 0) || ($user->isAnon() && $proj->id >0 && $proj->prefs['others_view'])):
			?><li>
			<a id="homelink"
				<?php if($do == 'index' && !(isset($_GET['dev']) && !$user->isAnon() && $_GET['dev'] == $user->id)): ?> class="active" <?php endif; ?>
			   href="<?php echo Filters::noXSS(CreateURL('tasklist', $proj->id)); ?>"><i class="fa fa-file-text-o"></i> <?php echo Filters::noXSS(L('tasklist')); ?></a>
			</li><?php
		endif;
		if(!$user->isAnon() && $proj->id != 0): ?><li>
			<a id="mytaskslink"
				<?php if($do == 'index' && isset($_GET['dev']) && $_GET['dev'] == $user->id): ?> class="active" <?php endif; ?>
			   href="<?php echo Filters::noXSS(CreateURL('mytasks', $proj->id, $user->id, null)); ?>"><span class="fa fa-stacka"><i class="fa fa-file-o fa-stack-1x"></i><i class="fa fa-check fa-stacka" style="color:inherit;"></i></span>&nbsp;<?php echo Filters::noXSS(L('myassignedtasks')); ?></a>
			</li><?php
		endif;
		if($user->perms('view_reports') && $proj->id != 0): ?><li>
			<a id="reportslink"
				<?php if( $do == 'reports'): ?> class="active" <?php endif; ?>
			   href="<?php echo Filters::noXSS(CreateURL('reports', $proj->id)); ?>"><i class="fa fa-calendar-o"></i> <?php echo Filters::noXSS(L('reports')); ?></a>
			</li><?php
		endif;
		if($proj->id && ($user->perms('view_roadmap') || ($user->isAnon() && $proj->prefs['others_viewroadmap'])) ): ?><li>
			<a id="roadmaplink"
				<?php if($do == 'roadmap'): ?> class="active" <?php endif; ?>
			   href="<?php echo Filters::noXSS(CreateURL('roadmap', $proj->id)); ?>"><i class="fa fa-road"></i> <?php echo Filters::noXSS(L('roadmap')); ?></a>
			</li><?php
		endif;
		if(file_exists(BASEDIR . '/scripts/gantt.php') && $proj->id && $user->perms('view_roadmap')): ?><li>
			<a id="gantt"
				<?php if($do == 'gantt'): ?> class="active" <?php endif; ?>
			   href="<?php echo Filters::noXSS(CreateURL('gantt', $proj->id)); ?>" title="Gantt chart"><i class="fa fa-tasks fa-lg"></i></a>
			</li><?php
		endif;
		if ($proj->id && $user->perms('manage_project')): ?><li>
			<a id="projectslink"<?php if($do=='pm'): ?> class="active"<?php endif; ?> href="<?php echo Filters::noXSS(CreateURL('pm', 'prefs', $proj->id)); ?>"><i class="fa fa-cog"></i> <?php echo Filters::noXSS(L('manageproject')); ?></a>
			</li><?php
		endif;
		if($proj->id && $user->perms('add_multiple_tasks')) :
			?><li>
			<a id="newmultitaskslink" href="<?php echo Filters::noXSS(CreateURL('newmultitasks', $proj->id)); ?>"
				<?php if($do == 'newmultitasks'): ?> class="active"<?php endif; ?>><?php echo Filters::noXSS(L('addmultipletasks')); ?></a>
			</li><?php
		endif;
		if ($proj->id && isset($pm_pendingreq_num) && $pm_pendingreq_num):
			?><li>
			<a class="pendingreq attention"
			   href="<?php echo Filters::noXSS(CreateURL('pm', 'pendingreq', $proj->id)); ?>"><?php echo Filters::noXSS($pm_pendingreq_num); ?> <?php echo Filters::noXSS(L('pendingreq')); ?></a>
			</li><?php
		endif;
		if ($user->perms('is_admin') && isset($admin_pendingreq_num) && $admin_pendingreq_num):
			?><li>
			<a class="pendingreq attention"
			   href="<?php echo Filters::noXSS(CreateURL('admin', 'userrequest')); ?>"><?php echo Filters::noXSS($admin_pendingreq_num); ?> <?php echo Filters::noXSS(L('adminrequestswaiting')); ?></a>
			</li><?php
		endif; ?>
	</ul>
</div>