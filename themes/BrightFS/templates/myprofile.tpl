<div class="box"><h3><?php echo Filters::noXSS(L('editmydetails')); ?></h3>
<?php $this->display('common.profile.tpl'); ?>
</div>
<div class="box" style="width: 30%"><h3><?php echo L('myvotes'); ?></h3>
<?php if(count($votes)>0): ?>
<table class="table table-hover table-striped" id="myvotes">
<thead>
<tr>
<th><?php echo L('project'); ?></th>
<th><?php echo L('task'); ?></th>
<th></th>
</tr>   
</thead>
<tbody>
<?php foreach($votes as $vote): ?>
<tr<?php echo $vote['is_closed'] ? ' class="closed"':''; ?>>
<td style="width: 30%;"><?php echo $vote['project_title']; ?></td>
<td style="overflow: hidden; text-overflow: ellipsis; max-width: 10ch; white-space: nowrap;"><?php echo $vote['item_summary']; ?></td>
<td style="width:10%;"><?php echo tpl_form(Filters::noXSS(CreateURL('myprofile', $vote['task_id'])));?>
<input type="hidden" name="action" value="removevote" />
<input type="hidden" name="task_id" value="<?php echo $vote['task_id']?>" />
<button class="ggl button red" type="submit" title="<?php echo eL('removevote'); ?>"><i class="fa fa-trash"></i></button>
</form></td>
</tr>
<?php endforeach; ?>
</tbody>
</table>
<?php else:
  echo L('novotes');
endif; ?>
</div>
<div class="box"><h3><?php echo eL('permissionsforproject').' '.$proj->prefs['project_title']; ?></h3><?php echo tpl_draw_perms($user->perms); ?></div>
<div class="clear"></div>
