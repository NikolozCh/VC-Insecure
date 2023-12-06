/* ###
 * IP: GHIDRA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package ghidra.pty.ssh;

import java.io.InputStream;
import java.io.OutputStream;

import com.jcraft.jsch.ChannelExec;

import ghidra.pty.PtyEndpoint;

public class SshPtyEndpoint implements PtyEndpoint {
	protected final ChannelExec channel;
	protected final OutputStream outputStream;
	protected final InputStream inputStream;

	public SshPtyEndpoint(ChannelExec channel, OutputStream outputStream, InputStream inputStream) {
		this.channel = channel;
		this.outputStream = outputStream;
		this.inputStream = inputStream;
	}

	@Override
	public OutputStream getOutputStream() {
		return outputStream;
	}

	@Override
	public InputStream getInputStream() {
		return inputStream;
	}
}
