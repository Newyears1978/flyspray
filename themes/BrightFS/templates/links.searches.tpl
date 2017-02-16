<?php # $fs->projects is filtered with can_select_project() for the current user/guest in index.php ?>
<?php if ( count($fs->projects) > 0 ) { ?>
	<li>
		<form action="<?php echo Filters::noXSS($baseurl); ?>index.php" method="get">
			<noscript><button type="submit"><?php echo Filters::noXSS(L('showtask')); ?> #</button></noscript>
			<input id="task_id" name="show_task" type="text" accesskey="t" placeholder="<?php echo Filters::noXSS(L('showtask')); ?> #" />
		</form>
	</li>
<?php } ?>
<li>
	<a class="dropdown-toggle" data-open-id="user-searches"><?php echo Filters::noXSS(L('mysearch')); ?></a>
	<ul id="user-searches" class="dropdown-menu">
		<?php if ( !count($user->searches) ) { ?><li class="dropdown-header"><?php echo Filters::noXSS(L('nosearches')); ?></li><?php } ?>
		<?php
		if ( count($user->searches) )
		{
			echo '<li class="hide"><input type="hidden" name="csrftoken" id="deletesearchtoken" value="' . $_SESSION['csrftoken'] . '" /></li>';
			foreach ($user->searches as $search)
			{
				echo '<li>';
				echo '<a href="' .  Filters::noXSS($baseurl) . '?do=index&amp;' . http_build_query(unserialize($search['search_string']), '', '&amp;') . '" >' . Filters::noXSS($search['name']) . ' ';
				echo '<span onclick="event.preventDefault(); alert(12);" class="pull-right" ><i class="fa fa-trash"></i></span></a>';
				echo '</li>';
			}
		}
		?>
	</ul>
</li>