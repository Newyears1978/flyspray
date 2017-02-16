<?php
$isAllProjects = false;
if ( isset($_GET['project']) && $_GET['project'] == 0 ) $isAllProjects = true;
?>
<?php if ( count($fs->projects) ) { ?>
	<li class="<?php if($do == 'toplevel' && $isAllProjects) { echo 'active'; } ?>"><a href="<?php echo Filters::noXSS(CreateURL('toplevel', 0)); ?>"><?php echo Filters::noXSS(L('projects')); ?></a></li>
<?php } ?>
<?php if( (!$user->isAnon() && $user->perms('view_tasks')) ) { ?>
	<li class="<?php if($do == 'index' && !isset($_GET['dev']) && $isAllProjects) { echo 'active'; } ?>"><a href="<?php echo Filters::noXSS(CreateURL('tasklist', 0)); ?>"><?php echo Filters::noXSS(L('tasksall')); ?></a></li>
<?php } ?>
<?php if ( !$user->isAnon() ) { ?>
	<li class="<?php if($do == 'index' && isset($_GET['dev']) && $_GET['dev'] == $user->id && $isAllProjects) { echo 'active'; } ?>"><a href="<?php echo Filters::noXSS(CreateURL('mytasks', 0, $user->id, null)); ?>"><?php echo Filters::noXSS(L('myassignedtasks')); ?></a></li>
<?php } ?>
<?php if ( !$user->isAnon() && $user->perms('view_reports') ) { ?>
	<li class="<?php if($do == 'reports' && $isAllProjects) { echo 'active'; } ?>"><a href="<?php echo Filters::noXSS(CreateURL('reports', 0)); ?>"><?php echo Filters::noXSS(L('reports')); ?></a></li>
<?php } ?>
<?php if ( !$user->isAnon() && $proj->id && $user->perms('open_new_tasks') ) { ?>
	<li><a id="newtasklink" href="<?php echo Filters::noXSS(CreateURL('newtask', $proj->id)); ?>" class="ggl button green"><i class="octicon octicon-file-text"></i> <span class="label"><?php echo Filters::noXSS(L('addnewtask')); ?></span></a></li>
<?php } elseif ( $user->isAnon() && $proj->id && $proj->prefs['anon_open'] ) { ?>
	<li><a id="newmultitaskslink" href="?do=newtask&amp;project=<?php echo Filters::noXSS($proj->id); ?>" class="ggl button green"><i class="octicon octicon-file-text"></i> <span class="label"><?php echo Filters::noXSS(L('opentaskanon')); ?></span></a></li>
<?php } ?>