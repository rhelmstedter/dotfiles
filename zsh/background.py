#!/usr/bin/env python3
import sys
import iterm2

profile = sys.argv[1]


async def main(connection):
    app = await iterm2.async_get_app(connection)
    # Query for the list of profiles so we can search by name. This returns a
    # subset of the full profiles so it's fast.
    partialProfiles = await iterm2.PartialProfile.async_query(connection)
    # Iterate over each partial profile
    for partial in partialProfiles:
        if partial.name == profile:
            # This is the one we're looking for. Change the current session's
            # profile.
            full = await partial.async_get_full_profile()
            await app.current_terminal_window.current_tab.current_session.async_set_profile(full)
            return

iterm2.run_until_complete(main)
