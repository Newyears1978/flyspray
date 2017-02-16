<div id="notify" class="tab">
	<?php $ni = 0; foreach ($notifications as $row): ?>
		<?php echo tpl_form(Filters::noXSS(CreateUrl('details', $task_details['task_id'])).'#notify',null,null,null,'style="display:none" id="notify_'.$ni.'"'); ?>
		<input type="hidden" name="action" value="remove_notification" />
		<input type="hidden" name="ids" value="<?php echo Filters::noXSS($task_details['task_id']); ?>" />
		<input type="hidden" name="user_id" value="<?php echo Filters::noXSS($row['user_id']); ?>" />
		<?php echo '</form>'; ?>
	<?php $ni++; endforeach; ?>
	
	<?php if ($user->perms('manage_project')): ?>
		<?php echo tpl_form(Filters::noXSS(CreateUrl('details', $task_details['task_id'])).'#notify',null,null,null,'style="display:none" id="add_notify"'); ?>
			<input type="hidden" name="user_name" id="notif_user_id" value="" />
			<input type="hidden" name="ids" value="<?php echo Filters::noXSS(Req::num('ids', $task_details['task_id'])); ?>" />
			<input type="hidden" name="action" value="details.add_notification" />
		<?php echo '</form>'; ?>
	<?php endif; ?>
	
	
	<table class="table table-nonfluid">
		<caption><em><?php echo Filters::noXSS(L('theseusersnotify')); ?></em></caption>
		<thead>
		<tr>
			<th colspan="2"><?php echo Filters::noXSS(L('user')); ?></th>
			<th><?php echo Filters::noXSS(L('quickaction')); ?></th>
		</tr>
		</thead>
		<tbody>
		<?php $ni = 0; foreach ($notifications as $row): ?>
		<tr>
			<td><?php echo tpl_userlinkavatar($row['user_id'], $fs->prefs['max_avatar_size'] / 2); ?></td>
			<td><?php echo tpl_userlink($row['user_id']); ?></td>
			<td><button class="ggl button red pull-right" onclick="jQuery('#<?php echo 'notify_'.$ni; ?>').submit();" type="button" style="width:100%"><i class="fa fa-remove"></i> <?php echo Filters::noXSS(L('remove')); ?></button></td>
		</tr>
		<?php $ni++; endforeach; ?>
		</tbody>
		<?php if ($user->perms('manage_project')): ?>
		<tr>
			<td colspan="2"><?php echo tpl_userselect('add_user_name', Req::val('user_name'), 'add_notif_user_id', array('style' => 'width:100%', 'placeholder' => Filters::noXSS(L('addusertolist')))); ?></td>
			<td><button class="ggl button green pull-right" onclick="jQuery('#notif_user_id').val(jQuery('#add_notif_user_id').val()); jQuery('#add_notify').submit();" type="button" style="width:100%"><i class="fa fa-plus"></i> <?php echo Filters::noXSS(L('add')); ?></button></td>
		</tr>
		<?php endif; ?>
	</table>
</div>

